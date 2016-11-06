require "spec_helper"

describe Sandcage do

  before do
    @sc = Sandcage::Client.new
  end

  
  it "has a version number" do
    expect(Sandcage::VERSION).not_to be nil
  end

  it "correctly runs list files" do
    payload = {}
    result = @sc.list_files_service(payload)
    expect(result.code).to eq(200)
    parsed_response = result.parsed_response
    expected_keys = ['status', 'request_id', 'error_msg']
    parsed_response.each do |key, value|
      expect(expected_keys).to include(key)
    end
  end
  
  it "correctly runs list files with page" do
    payload = { page: 2}
    result = @sc.list_files_service(payload)
    expect(result.code).to eq(200)
    parsed_response = result.parsed_response
    expected_keys = ['status', 'request_id', 'error_msg']
    parsed_response.each do |key, value|
      expect(expected_keys).to include(key)
    end
  end  
    
  it "correctly runs list files with page and results per page" do
    payload = { page: 2,
                results_per_page: 10}
    result = @sc.list_files_service(payload)
    expect(result.code).to eq(200)
    parsed_response = result.parsed_response
    expected_keys = ['status', 'request_id', 'error_msg']
    parsed_response.each do |key, value|
      expect(expected_keys).to include(key)
    end
  end
  
  it "correctly runs get info with request id" do
    payload = { request_id: 'request_id' }
    result = @sc.get_info_service(payload)
    expect(result.code).to eq(200)
    parsed_response = result.parsed_response
    expected_keys = ['status', 'request_id', 'error_msg']
    parsed_response.each do |key, value|
      expect(expected_keys).to include(key)
    end
  end  
    
  it "correctly runs get info with file tokes" do
    payload = { files: [{ file_token: '[file_token 1]' },
                       { file_token: '[file_token 2]' },
                       { file_token: '[file_token 3]' }]}
    result = @sc.get_info_service(payload)
    expect(result.code).to eq(200)
    parsed_response = result.parsed_response
    expected_keys = ['status', 'request_id', 'error_msg']
    parsed_response.each do |key, value|
      expect(expected_keys).to include(key)
    end
  end
  
  it "correctly runs schedule files" do
    payload = { jobs: [
                  { url: 'http://cdn.sandcage.com/p/a/img/logo.jpg',
                    tasks: [
                      { actions: 'save' },
                      { actions: 'resize',
                        filename: 'hello_world.jpg',
                        width: 200 },
                      { actions: 'crop',
                        coords: '10,10,50,50'},
                      { reference_id: '1234567890',
                        actions: 'rotate',
                        degrees: 90 },
                      { actions: 'cover',
                        width: 60,
                        height: 60,
                        cover: 'middle,center' }]},
                  { url: 'http://cdn.sandcage.com/p/a/img/header_404.png',
                    tasks: [{ actions: 'resize',
                              height: 30 }]}]}
    result = @sc.schedule_files_service(payload)
    expect(result.code).to eq(200)
    parsed_response = result.parsed_response
    expected_keys = ['status', 'request_id', 'error_msg']
    parsed_response.each do |key, value|
      expect(expected_keys).to include(key)
    end
  end
    
  it "correctly runs destroy files" do
    payload = { files: [{ reference_id: 'reference_id' },
                        { file_token: 'file_token' }]}
    result = @sc.destroy_files_service(payload)
    expect(result.code).to eq(200)
    parsed_response = result.parsed_response
    expected_keys = ['status', 'request_id', 'error_msg']
    parsed_response.each do |key, value|
      expect(expected_keys).to include(key)
    end
  end
end
