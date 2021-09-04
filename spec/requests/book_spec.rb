require 'rails_helper'

describe "Book Api", type: :request do
    it 'return all books' do
        FactoryBot.create(:book, author:"test1", title: "test1")
        FactoryBot.create(:book, author:"test2", title: "test2")

        get '/api/v1/books'

        expect(response).to have_http_status(:success)  
        expect(JSON.parse(response.body).size).to eq(2)  
    end
end
