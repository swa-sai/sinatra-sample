require 'logger'

module Helper
  def self.randam(logger)
     logger.info "random log.."
  end

  def self.memory_leak(logger)
    a = []
    b = {}
    a << "abcdefghijabcdefghijabcdefghij"
    loop{
        sleep(0.01)
        1000.times { 
            if a.last().length() > 10000
                a << a.last().slice(0,6000)
            else
                a << a.last() + "abcdefghijabcdefghijabcdefghij"    
            end
        }
        logger.info GC.stat(b)[:heap_live_slots]
        if GC.stat(b)[:heap_live_slots] > 2167836
            logger.error "OUT OF MEMEORY!!!"
            break
        end
    }
  end

  def self.cpu(logger)
    100.times{
        #sleep(0.5)
        a = 0
        starting = Process.clock_gettime(Process::CLOCK_MONOTONIC)
        while a < 100000000
            a = a + 1
        end
        ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)
        logger.info "elapsed time: " + (ending - starting).to_s
    }
  end
end