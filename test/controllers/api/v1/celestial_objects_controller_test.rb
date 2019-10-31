# frozen_string_literal: true

require 'test_helper'

module Api
  module V1
    class CelestialObjectsControllerTest < ActionController::TestCase
      setup do
        @request.headers['Accept'] = Mime[:json]
        @request.headers['Content-Type'] = Mime[:json].to_s
      end

      tests Api::V1::CelestialObjectsController

      let(:crusader) { celestial_objects :crusader }
      let(:hurston) { celestial_objects :hurston }
      let(:yela) { celestial_objects :yela }
      let(:daymar) { celestial_objects :daymar }
      let(:index_result) do
        [{
          'name' => 'Hurston',
          'slug' => 'hurston',
          'type' => nil,
          'designation' => '1',
          'storeImage' => hurston.store_image.url,
          'storeImageMedium' => hurston.store_image.medium.url,
          'storeImageSmall' => hurston.store_image.small.url,
          'description' => nil,
          'habitable' => nil,
          'fairchanceact' => nil,
          'subType' => nil,
          'size' => nil,
          'danger' => nil,
          'economy' => nil,
          'population' => nil,
          'locationLabel' => hurston.location_label,
          'moons' => [],
          'starsystem' => {
            'name' => 'Stanton',
            'slug' => 'stanton',
            'storeImage' => hurston.starsystem.store_image.url,
            'storeImageMedium' => hurston.starsystem.store_image.medium.url,
            'storeImageSmall' => hurston.starsystem.store_image.small.url,
            'description' => nil,
            'mapX' => nil,
            'mapY' => nil,
            'type' => nil,
            'size' => nil,
            'population' => nil,
            'economy' => nil,
            'danger' => nil,
            'status' => nil,
            'locationLabel' => hurston.starsystem.location_label,
          },
          'createdAt' => hurston.created_at.utc.iso8601,
          'updatedAt' => hurston.updated_at.utc.iso8601
        }, {
          'name' => 'Crusader',
          'slug' => 'crusader',
          'type' => nil,
          'designation' => '2',
          'storeImage' => crusader.store_image.url,
          'storeImageMedium' => crusader.store_image.medium.url,
          'storeImageSmall' => crusader.store_image.small.url,
          'description' => nil,
          'habitable' => nil,
          'fairchanceact' => nil,
          'subType' => nil,
          'size' => nil,
          'danger' => nil,
          'economy' => nil,
          'population' => nil,
          'locationLabel' => crusader.location_label,
          'moons' => [{
            'name' => 'Yela',
            'slug' => 'yela',
            'type' => nil,
            'designation' => '3',
            'storeImage' => crusader.moons.first.store_image.url,
            'storeImageMedium' => crusader.moons.first.store_image.medium.url,
            'storeImageSmall' => crusader.moons.first.store_image.small.url,
            'description' => nil,
            'habitable' => nil,
            'fairchanceact' => nil,
            'subType' => nil,
            'size' => nil,
            'danger' => nil,
            'economy' => nil,
            'population' => nil,
            'locationLabel' => crusader.moons.first.location_label,
          }, {
            'name' => 'Daymar',
            'slug' => 'daymar',
            'type' => nil,
            'designation' => '4',
            'storeImage' => crusader.moons.last.store_image.url,
            'storeImageMedium' => crusader.moons.last.store_image.medium.url,
            'storeImageSmall' => crusader.moons.last.store_image.small.url,
            'description' => nil,
            'habitable' => nil,
            'fairchanceact' => nil,
            'subType' => nil,
            'size' => nil,
            'danger' => nil,
            'economy' => nil,
            'population' => nil,
            'locationLabel' => crusader.moons.last.location_label,
          }],
          'starsystem' => {
            'name' => 'Stanton',
            'slug' => 'stanton',
            'storeImage' => crusader.starsystem.store_image.url,
            'storeImageMedium' => crusader.starsystem.store_image.medium.url,
            'storeImageSmall' => crusader.starsystem.store_image.small.url,
            'description' => nil,
            'mapX' => nil,
            'mapY' => nil,
            'type' => nil,
            'size' => nil,
            'population' => nil,
            'economy' => nil,
            'danger' => nil,
            'status' => nil,
            'locationLabel' => crusader.starsystem.location_label,
          },
          'createdAt' => crusader.created_at.utc.iso8601,
          'updatedAt' => crusader.updated_at.utc.iso8601
        }, {
          'name' => 'Yela',
          'slug' => 'yela',
          'type' => nil,
          'designation' => '3',
          'storeImage' => yela.store_image.url,
          'storeImageMedium' => yela.store_image.medium.url,
          'storeImageSmall' => yela.store_image.small.url,
          'description' => nil,
          'habitable' => nil,
          'fairchanceact' => nil,
          'subType' => nil,
          'size' => nil,
          'danger' => nil,
          'economy' => nil,
          'population' => nil,
          'locationLabel' => yela.location_label,
          'moons' => [],
          'starsystem' => {
            'name' => 'Stanton',
            'slug' => 'stanton',
            'storeImage' => yela.starsystem.store_image.url,
            'storeImageMedium' => yela.starsystem.store_image.medium.url,
            'storeImageSmall' => yela.starsystem.store_image.small.url,
            'description' => nil,
            'mapX' => nil,
            'mapY' => nil,
            'type' => nil,
            'size' => nil,
            'population' => nil,
            'economy' => nil,
            'danger' => nil,
            'status' => nil,
            'locationLabel' => yela.starsystem.location_label,
          },
          'createdAt' => yela.created_at.utc.iso8601,
          'updatedAt' => yela.updated_at.utc.iso8601
        }, {
          'name' => 'Daymar',
          'slug' => 'daymar',
          'type' => nil,
          'designation' => '4',
          'storeImage' => daymar.store_image.url,
          'storeImageMedium' => daymar.store_image.medium.url,
          'storeImageSmall' => daymar.store_image.small.url,
          'description' => nil,
          'habitable' => nil,
          'fairchanceact' => nil,
          'subType' => nil,
          'size' => nil,
          'danger' => nil,
          'economy' => nil,
          'population' => nil,
          'locationLabel' => daymar.location_label,
          'moons' => [],
          'starsystem' => {
            'name' => 'Stanton',
            'slug' => 'stanton',
            'storeImage' => daymar.starsystem.store_image.url,
            'storeImageMedium' => daymar.starsystem.store_image.medium.url,
            'storeImageSmall' => daymar.starsystem.store_image.small.url,
            'description' => nil,
            'mapX' => nil,
            'mapY' => nil,
            'type' => nil,
            'size' => nil,
            'population' => nil,
            'economy' => nil,
            'danger' => nil,
            'status' => nil,
            'locationLabel' => daymar.starsystem.location_label,
          },
          'createdAt' => daymar.created_at.utc.iso8601,
          'updatedAt' => daymar.updated_at.utc.iso8601
        }]
      end
      let(:show_result) do
        {
          'name' => 'Crusader',
          'slug' => 'crusader',
          'type' => nil,
          'designation' => '2',
          'storeImage' => crusader.store_image.url,
          'storeImageMedium' => crusader.store_image.medium.url,
          'storeImageSmall' => crusader.store_image.small.url,
          'description' => nil,
          'habitable' => nil,
          'fairchanceact' => nil,
          'subType' => nil,
          'size' => nil,
          'danger' => nil,
          'economy' => nil,
          'population' => nil,
          'locationLabel' => crusader.location_label,
          'moons' => [{
            'name' => 'Yela',
            'slug' => 'yela',
            'type' => nil,
            'designation' => '3',
            'storeImage' => crusader.moons.first.store_image.url,
            'storeImageMedium' => crusader.moons.first.store_image.medium.url,
            'storeImageSmall' => crusader.moons.first.store_image.small.url,
            'description' => nil,
            'habitable' => nil,
            'fairchanceact' => nil,
            'subType' => nil,
            'size' => nil,
            'danger' => nil,
            'economy' => nil,
            'population' => nil,
            'locationLabel' => crusader.moons.first.location_label,
          }, {
            'name' => 'Daymar',
            'slug' => 'daymar',
            'type' => nil,
            'designation' => '4',
            'storeImage' => crusader.moons.last.store_image.url,
            'storeImageMedium' => crusader.moons.last.store_image.medium.url,
            'storeImageSmall' => crusader.moons.last.store_image.small.url,
            'description' => nil,
            'habitable' => nil,
            'fairchanceact' => nil,
            'subType' => nil,
            'size' => nil,
            'danger' => nil,
            'economy' => nil,
            'population' => nil,
            'locationLabel' => crusader.moons.last.location_label,
          }],
          'starsystem' => {
            'name' => 'Stanton',
            'slug' => 'stanton',
            'storeImage' => crusader.starsystem.store_image.url,
            'storeImageMedium' => crusader.starsystem.store_image.medium.url,
            'storeImageSmall' => crusader.starsystem.store_image.small.url,
            'description' => nil,
            'mapX' => nil,
            'mapY' => nil,
            'type' => nil,
            'size' => nil,
            'population' => nil,
            'economy' => nil,
            'danger' => nil,
            'status' => nil,
            'locationLabel' => crusader.starsystem.location_label,
          },
          'createdAt' => crusader.created_at.utc.iso8601,
          'updatedAt' => crusader.updated_at.utc.iso8601
        }
      end

      describe 'without session' do
        it 'should return list for index' do
          get :index

          assert_response :ok
          json = JSON.parse response.body

          assert_equal index_result, json
        end

        it 'should return a single record for show' do
          get :show, params: { slug: crusader.slug }

          assert_response :ok
          json = JSON.parse response.body

          assert_equal show_result, json
        end
      end

      describe 'with session' do
        let(:data) { users :data }

        before do
          sign_in data
        end

        it 'should return list for index' do
          get :index

          assert_response :ok
          json = JSON.parse response.body

          assert_equal index_result, json
        end

        it 'should return a single record for show' do
          get :show, params: { slug: crusader.slug }

          assert_response :ok
          json = JSON.parse response.body

          assert_equal show_result, json
        end
      end
    end
  end
end
