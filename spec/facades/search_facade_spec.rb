require 'rails_helper'

describe 'Search Facade' do
  it 'returns search results' do
    title = "The Godfather: Part II"
    result = SearchFacade.results(title)

    expect(result).to be_an(Array)
    expect(result.size).to eq(2)
    expect(result.first).to be_an_instance_of(Search)
  end

  it "returns cast members" do
    id = 240
    result = SearchFacade.credits(id)
    expect(result).to be_an(Array)
    expect(result.size).to eq(10)
  end
end
