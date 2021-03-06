require 'mime/types'

class BinaryFile < ActiveRecord::Base

  # File management and restrictions
  include GSP::FileManager::BinaryFileHandler
  include GSP::FileManager::Storage
  #accept_only_binary_file_subclasses

  attr_accessible :filename, :mime_types, :user
  belongs_to :attachable, :polymorphic => true
  belongs_to :user

  serialize :mime_types, JSON

  after_commit :save_to_filesystem!
end
