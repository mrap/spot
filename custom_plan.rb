require 'zeus/parallel_tests'

class CustomPlan < Zeus::ParallelTests::Rails

  def spec(argv=ARGV)
    # disable autorun in case the user left it in spec_helper.rb
    RSpec::Core::Runner.disable_autorun!
    exit RSpec::Core::Runner.run(argv)
  end
end

Zeus.plan = CustomPlan.new
