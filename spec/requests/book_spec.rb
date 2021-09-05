require 'rails_helper'

describe "Book Api", type: :request do
    describe "GET /books" do
        it 'return all books' do
            FactoryBot.create(:book, author:"test1", title: "test1")
            FactoryBot.create(:book, author:"test2", title: "test2")
    
            get '/api/v1/books'
    
            expect(response).to have_http_status(:success)  
            expect(JSON.parse(response.body).size).to eq(2)  
        end
    end

    describe "POST /books" do
        it 'create new book' do
            expect{
                post '/api/v1/books', params: {
                    author: {
                        first_name: "test1",
                        last_name: "test1",
                        age: 27
                    },
                    book: {title: "test1"}
                }
            }.to change { Book.count }.from(0).to(1)
    
            expect(response).to have_http_status(:created) 
            expect(Author.count).to eq(1)
        end
    end

    describe "Destroy /books/:id" do
        it 'delete a book' do
            book = FactoryBot.create(:book, author:"test1", title: "test1")
            
            expect{
                delete "/api/v1/books/#{book.id}"
            }.to change { Book.count }.from(1).to(0)
    
            expect(response).to have_http_status(:no_content)  
        end
    end
end
