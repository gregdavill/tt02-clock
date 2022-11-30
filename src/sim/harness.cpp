#include "harness.h"

harness::harness(void)
{
    /* Run through reset step */
    top.step();
    top.p_i__rst.set<bool>(true);
    step();
    step();
    top.p_i__rst.set<bool>(false);

    /* Spin up new thread to clock the rtl model */
    th = new std::thread(&harness::thread_func, this);
}

void harness::step(void)
{
    m.lock();
    {
        cycles++;

        top.p_i__clk.set(false);
        top.step();
        top.p_i__clk.set(true);
        top.step();

        sr_logic();
    }
    m.unlock();
}

void harness::i_minute(bool v)
{
    m.lock();
    {
        top.p_i__min__up.set<bool>(v);
    }
    m.unlock();
}

void harness::i_hour(bool v)
{
    m.lock();
    {
        top.p_i__hour__up.set<bool>(v);
    }
    m.unlock();
}

int harness::get_cycles()
{
    int _cycles;
    m.lock();
    {
        _cycles = cycles;
    }
    m.unlock();
    return _cycles;
}

void harness::sr_logic()
{
    static bool clk_r = false;
    static bool latch_r = false;

    bool clk = top.p_o__clk.get<bool>();
    bool latch = top.p_o__latch.get<bool>();
    bool bit = top.p_o__bit.get<bool>();

    /* Rising latch */
    if (latch & !latch_r)
    {
        for (int i = 0; i < 6; i++)
        {
            seg[i] = sr_unlatch[i];
        }
    }

    /* Rising clock */
    if (clk & !clk_r)
    {
        bool carry = bit;
        for (int i = 0; i < (6); i++)
        {
            bool new_carry = sr_unlatch[i] & 0x80 ? 1 : 0;
            sr_unlatch[i] = (sr_unlatch[i] << 1) | carry;

            carry = new_carry;
        }
    }

    /* Used for edge detection */
    clk_r = clk;
    latch_r = latch;
}

void harness::thread_func()
{
    while (true)
    {
        step();
        std::this_thread::sleep_for(std::chrono::milliseconds(8)); /* ~128Hz */
    }
}
