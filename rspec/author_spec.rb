require_relative '../author'

describe Author do
  before :each do
    @author = Author.new('John', 'Doe')
  end

  it 'Checks for Author first name' do
    expect(@author.first_name).to eq('John')
  end

  it 'checks for Author last name' do
    expect(@author.last_name).to eq('Doe')
  end

  it 'check for Author instance' do
    expect(@author).to be_an_instance_of(Author)
  end
  # context 'Check author class' do
  #   it 'The initialize method should return create new Author object' do
  #     author = Author.new('John', 'Doe')
  #     expect(author.first_name).to eq 'John'
  #   end
  # end
end
