require "spec_helper"

describe Sandcage do

  before do
    # Save the API_KEY to your home directory as a file named
    # SANDCAGE_API_KEY
    api_key_dir = File.expand_path("~")
    api_key_file = File.join(api_key_dir, "SANDCAGE_API_KEY")
    api_key = IO.readlines(api_key_file)[0]
    @sc = Sandcage::Client.new(api_key)
  end

  it "correctly runs list files" do
    payload = {}
    result = @sc.list_files_service(payload)
    expect(result.code).to eq(200)
    parsed_response = result.parsed_response
    expected_keys = ['status', 'request_id', 'pages', 'files']
    not_expected_keys = ['error_msg']
    parsed_response.each do |key, value|
      expect(expected_keys).to include(key)
      expect(not_expected_keys).not_to include(key)
    end
  end
  
  it "correctly runs list files with page" do
    payload = { page: 2 }
    result = @sc.list_files_service(payload)
    expect(result.code).to eq(200)
    parsed_response = result.parsed_response
    expected_keys = ['status', 'request_id', 'pages', 'files']
    not_expected_keys = ['error_msg']
    parsed_response.each do |key, value|
      expect(expected_keys).to include(key)
      expect(not_expected_keys).not_to include(key)
    end
  end
  
  it "correctly runs list files with page and results per page" do
    payload = { page: 2,
                results_per_page: 10 }
    result = @sc.list_files_service(payload)
    expect(result.code).to eq(200)
    parsed_response = result.parsed_response
    expected_keys = ['status', 'request_id', 'pages', 'files']
    not_expected_keys = ['error_msg']
    parsed_response.each do |key, value|
      expect(expected_keys).to include(key)
      expect(not_expected_keys).not_to include(key)
    end
  end
  
end
