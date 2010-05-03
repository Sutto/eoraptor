require 'digest/sha2'

class SimpleUser
  
  def self.authentication_hashes
    @authentication_hashes ||= begin
      YAML.load(Rails.root.join('config', 'users.yml').read).map { |r| OpenStruct.new(r) }.each do |r|
        r.username.downcase!
      end
    end
  end
  
  def self.valid_user?(username, password)
    return false if username.blank? || password.blank?
    user = self.user(username.downcase)
    user.present? && user.password_hash == Digest::SHA256.hexdigest(password)
  end
  
  def self.user(username)
    authentication_hashes.detect { |r| r.username == username }
  end
  
end