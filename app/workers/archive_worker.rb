class ArchiveWorker
  include Sidekiq::Worker

  def perform(user_id)
    user = User.find(user_id)
    puts user.archive 
  end
  
  
end