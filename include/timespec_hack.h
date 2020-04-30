// This is a hack to make musl builds work
// See: https://github.com/ziglang/zig/blob/15141d865abda09c09d8f6e3385f127527c5232e/lib/libc/include/x86_64-linux-musl/bits/alltypes.h#L229
#if !defined TIMESPEC_HACK_H
#define TIMESPEC_HACK_H

#if !defined(__GLIBC__)
#define __DEFINED_struct_timespec

#define __NEED_time_t
#include <bits/alltypes.h>

_Static_assert(sizeof(time_t) == sizeof(long), "assert");

struct timespec {
	time_t tv_sec;
	long tv_nsec;
};

#endif // if !defined(__GLIBC__)

#endif // TIMESPEC_HACK_H
