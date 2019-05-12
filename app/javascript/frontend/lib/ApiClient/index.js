import axios from 'axios'
import nprogress from 'nprogress'
import Store from 'frontend/lib/Store'
import { alert } from 'frontend/lib/Noty'
import I18n from 'frontend/lib/I18n'
import linkHeaderParser from 'parse-link-header'
import axiosDefaults from 'axios/lib/defaults'

const client = axios.create({
  baseURL: window.API_ENDPOINT,
  headers: {
    common: {
      Accept: 'application/json',
      'Content-Type': 'application/json',
    },
  },
  transformRequest: axiosDefaults.transformRequest.concat(
    (data, headers) => {
      nprogress.start()

      if (Store.getters['session/isAuthenticated']) {
        // eslint-disable-next-line no-param-reassign
        headers.Authorization = `Bearer ${Store.getters['session/authToken']}`
      }

      return data
    },
  ),
})

const { CancelToken } = axios

const cancelations = {}

const extractMetaInfo = function extractMetaInfo(headers, params) {
  const links = linkHeaderParser(headers.link)
  let meta = null
  if (links) {
    meta = {
      currentPage: parseInt(params.page || 1, 10),
      totalPages: parseInt((links.last && links.last.page) || params.page || 1, 10),
    }
  }
  return meta
}

const handleError = async function handleError(error) {
  nprogress.done()

  if (error.message !== 'cancel' && (!error.response || !error.response.data || !error.response.data.message)) {
    alert(I18n.t('messages.error.default'))
  }

  if (error.response && error.response.status === 401 && Store.getters['session/isAuthenticated']) {
    Store.dispatch('session/logout', true)
  }

  return {
    data: null,
    meta: null,
    error,
  }
}

const handleResponse = function handleResponse(response, params) {
  nprogress.done()

  const meta = extractMetaInfo(response.headers, params)

  return {
    data: response.data,
    error: null,
    meta,
    params,
  }
}

export async function get(path, params = {}) {
  try {
    return handleResponse(await client.get(path, {
      params,
      cancelToken: new CancelToken((c) => {
        if (cancelations[path]) {
          cancelations[path]('cancel')
        }
        cancelations[path] = c
      }),
    }), params)
  } catch (error) {
    return handleError(error)
  }
}

export async function post(path, body = {}) {
  try {
    return handleResponse(await client.post(path, body), body)
  } catch (error) {
    return handleError(error)
  }
}

export async function put(path, body = {}) {
  try {
    return handleResponse(await client.put(path, body), body)
  } catch (error) {
    return handleError(error)
  }
}

export async function destroy(path, data = {}) {
  try {
    return handleResponse(await client.delete(path, { data }))
  } catch (error) {
    return handleError(error)
  }
}

export const apiClient = {
  get, post, put, destroy, client,
}
