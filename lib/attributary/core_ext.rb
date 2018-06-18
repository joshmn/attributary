class String
  unless String.respond_to?(:constantize)
    def constantize
      Object.const_get(self)
    end
  end

  unless String.respond_to?(:safe_constantize)
    def safe_constantize
      constantize rescue nil
    end
  end
end
