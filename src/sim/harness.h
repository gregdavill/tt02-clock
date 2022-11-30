
#include <thread>
#include <chrono>
#include <mutex>

#include "clock.sim.h"

class harness
{
public:
    harness(void);
    void step(void);
    void i_minute(bool v);
    void i_hour(bool v);
    int get_cycles(void);

    unsigned char seg[6];

private:
    void sr_logic(void);
    void thread_func(void);

    unsigned char sr_unlatch[6];

    cxxrtl_design::p_clock top;
    std::mutex m;
    std::thread *th;

    int cycles = 0;
};
