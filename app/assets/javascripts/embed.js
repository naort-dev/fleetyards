const host = `${window.location.protocol}//${window.location.host}`

const d = document
const styles = d.createElement('link')
styles.href = `${host}/embed-styles.css#${+new Date()}`
styles.rel = 'stylesheet'
styles.type = 'text/css';
(d.head || d.body).appendChild(styles)

const fonts = d.createElement('link')
fonts.href = '//fonts.googleapis.com/css?family=Open+Sans:400,700|Orbitron:400,500,700,900'
fonts.rel = 'stylesheet'
fonts.media = 'all';
(d.head || d.body).appendChild(fonts)

console.log('foo')

fetch(`${host}/embed-chunks.json`).then(response => response.json()).then((chunks) => {
  chunks.forEach((chunkUrl) => {
    const chunk = d.createElement('script')
    chunk.src = chunkUrl
    chunk.type = 'application/javascript'
    const parent = d.head || d.body
    parent.appendChild(chunk)
  })
})
