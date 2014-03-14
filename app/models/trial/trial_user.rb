class Trial::TrialUser < User
  validate :email_cannot_contain_a_forbidden_domain
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
        errors.add(:email, "is invalid")
        break
      end
    end
  end
end
