class Trial::TrialUser < User
  validate :email_cannot_contain_a_forbidden_domain, :email_domain_cannot_exist
  after_initialize do |trial_user|
    trial_user.trial_created_at = Time.now
  end

  def self.trial_period
    2.weeks
  end

  def self.forbidden_domains
    %w(gmail yahoo hotmail outlook hushmail aol gmx inbox)
  end

  def email_cannot_contain_a_forbidden_domain
    domain = email.split("@").last
    Trial::TrialUser.forbidden_domains.each do |fd|
      if domain.include?(fd)
        errors.add(:email, " from '#{domain}' is invalid. Please use your company's email address.")
        break
      end
    end
  end

  def email_domain_cannot_exist
    domain = email.split('@').last
    if domain != "greenstatuspro.com" &&
      !Trial::TrialUser.where("email LIKE ?", "%@#{domain}").where("id IS NOT ?", self.id).empty?
      errors.add(:email, "domain '#{domain}' has been previously registered")
      return false
    end
  end
end
