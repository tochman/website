
Given(/^the following contributors exist:$/) do |c_table|
  contributors = Array.new
  c_table.hashes.each do |contributor|
    contributors << contributor
  end

  stub_request(:get, /api.github.com/).
      with(:headers => {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
      to_return(:status => 200, :body => contributors.to_json, :headers => {})

end