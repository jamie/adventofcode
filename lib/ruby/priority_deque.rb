class PriorityDeque
  attr_reader :queue

  def initialize(prior=:max)
    @prior = prior
    @queue = {}
  end

  def empty?
    @queue.empty?
  end

  def priority
    queue.keys.send(@prior)
  end

  def add(priority, value)
    @queue[priority] ||= []
    @queue[priority] << value
  end

  def pop
    value = @queue[priority].pop
    if @queue[priority].empty?
      @queue.delete(priority)
    end
    value
  end

  def shift
    value = @queue[priority].shift
    if @queue[priority].empty?
      @queue.delete(priority)
    end
    value
  end

  def size
    @queue.values.sum(&:size)
  end
end
