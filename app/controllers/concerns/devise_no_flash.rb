module DeviseNoFlash
  extend ActiveSupport::Concern

  included do
    private

    def set_flash_message!(key, kind, options = {})
      # Do nothing
    end

    def set_flash_message(key, kind, options = {})
      # Do nothing
    end
  end
end
