class ArchiveWorker
  include Sidekiq::Worker

  def perform(user_id)
    user = User.find(user_id)
    user.archive 
  end
  
  
end