require 'rspec'
require 'rspec/core/formatters/base_formatter'
require 'getting_dumped/models'

class GettingDumped < RSpec::Core::Formatters::BaseFormatter
  def initialize(options)
    super
    @success = true
    @run = Run.create!(:started_at => Time.now)
  end

  def start(count)
    super
  end

  def example_started(example)
    super
  end

  def example_pending(example)
    super
    save_example(example)
  end

  def example_passed(example)
    super
    save_example(example)
  end

  def example_failed(example)
    super
    save_example(example)
    @success = false
  end

  def start_dump
    super
    time = DateTime.now
    @run.ended_at = time
    @run.success = @success
    @run.run_time = time - @run.started_at
    @run.save
  end

  private

  def save_example(example)
    metadata = example.metadata[:execution_result]
    ex = Example.new(:name => example.full_description, :started_at => metadata[:finished_at], :finished_at => metadata[:finished_at],
                     :run_time => metadata[:run_time], :status => metadata[:status], :run_id => @run.id)
    if metadata[:status] == "failed"
      exception = metadata[:exception_encountered] || metadata[:exception] # rspec 2.0 || rspec 2.2
      ex.backtrace = exception.backtrace
      ex.exception = read_failed_line(exception, example)
    end
    ex.save
  end

end
