require 'rails_helper'

describe "Book Api", type: :request do
    let(:first_author) {FactoryBot.create(:author, first_name:"test1", last_name: "test1", age: 27)}
    let(:second_author) {FactoryBot.create(:author, first_name:"test2", last_name: "test2", age: 29)}

    describe "GET /books" do
        it 'return all books' do
            FactoryBot.create(:book, author:first_author, title: "test1")
            FactoryBot.create(:book, author:second_author, title: "test2")
    
            get '/api/v1/books'
    
            expect(response).to have_http_status(:success)  
            expect(response_body.size).to eq(2) 
            expect(response_body).to eq(
                [
                    {
                    'id' =>  1,
                    'title' =>  "test1",
                    'author_name' =>  "test1 test1",
                    'author_age' =>  27
                    },
                    {
                        'id' =>  2,
                        'title' =>  "test2",
                        'author_name' =>  "test2 test2",
                        'author_age' =>  29
                    }
                ]
            )
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
            expect(response_body).to eq(
                {
                    'id' =>  1,
                    'title' =>  "test1",
                    'author_name' =>  "test1 test1",
                    'author_age' =>  27
                }
            )
        end
    end

    describe "Destroy /books/:id" do
        it 'delete a book' do
            book = FactoryBot.create(:book, author: first_author, title: "test1")
            
            expect{
                delete "/api/v1/books/#{book.id}"
            }.to change { Book.count }.from(1).to(0)
    
            expect(response).to have_http_status(:no_content)  
        end
    end
end
