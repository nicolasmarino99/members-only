# frozen_string_literal: true

require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test 'should get home' do
    get static_pages_home_url
    assert_response :success
  end

  test 'should get snippets' do
    get static_pages_snippets_url
    assert_response :success
  end

  test 'should get newsletter' do
    get static_pages_newsletter_url
    assert_response :success
  end

  test 'should get jobs' do
    get static_pages_jobs_url
    assert_response :success
  end

  test 'should get videos' do
    get static_pages_videos_url
    assert_response :success
  end

  test 'should get guides' do
    get static_pages_guides_url
    assert_response :success
  end
end
