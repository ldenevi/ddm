class Cfsi::CmrtController < ApplicationController
  def index
    @validations_batches = Cfsi::ValidationsBatch.where(:user_id => current_user) || []
  end
end
