class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  validates :email, :uniqueness => true
end

class User < ApplicationRecord

  validates :login, :uniqueness => {:scope => :application_id, :case_sensitive => false, :message => "has already been taken."}
  validates :blob_id, :uniqueness => true
  validates :password, :length => {:within => 8..40}, :confirmation => true
  validates :website, :length => {:in => 0..200},
                      :allow_nil => true
end

class Application < ApplicationRecord
  validates :title, uniqueness: { scope: :account_id, case_sensitive: false }
end
