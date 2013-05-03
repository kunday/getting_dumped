require 'rspec'
require 'rspec/core/formatters/base_formatter'
require 'getting_dumped/migrations/create_tables'


class GettingDumped < RSpec::Core::Formatters::BaseFormatter
  def initialize(options)
    super(options)
    @run_started_at = Time.now
    @run = DB[:runs]
    @example_db = DB[:examples]
    @success = true
    @run_id = @run.insert(:started_at => Time.now)
  end

  def start(count)
    super(count)
  end

  def example_started(example)
    super(example)
  end

  def example_pending(example)
    super(example)
    save_example(example)
  end

  def example_passed(example)
    super(example)
    save_example(example)
  end

  def example_failed(example)
    super(example)
    save_example(example)
    @success = false
  end

  def start_dump
    super
    time = Time.now
    @run.where('id = ?', @run_id).update(
      :ended_at => time,
      :success => @success,
      :run_time => time - @run_started_at
    )
  end

  private

  def save_example(example)
    metadata = example.metadata[:execution_result]
    exception = nil
    backtrace = nil
    exception = nil
    if metadata[:status] == "failed"
      exception = metadata[:exception_encountered] || metadata[:exception] # rspec 2.0 || rspec 2.2
      backtrace = exception.backtrace
      exception = read_failed_line(exception, example)
    end
    @example_db.insert(:name => example.full_description,
                       :status => metadata[:status],
                       :run_id => @run_id,
                       :run_time => metadata[:run_time],
                       :started_at => DateTime.parse(metadata[:started_at].to_s),
                       :finished_at => DateTime.parse(metadata[:finished_at].to_s),
                       :exception => exception.to_s,
                       :backtrace => backtrace.to_s
                      )
  end

end
