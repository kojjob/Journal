json.extract! journal, :id, :title, :content, :author, :published_at, :created_at, :updated_at
json.url journal_url(journal, format: :json)
