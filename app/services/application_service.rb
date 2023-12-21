class ApplicationService
  def self.execute(*args, &block)
    new(*args.dup, &block).execute
  end
end
