#line 1 "/Users/alonemonkey/Documents/MonkeyDev/ab/FrogTweak/FrogTweak/FrogTweak.xm"
#import <substrate.h>
#import <dlfcn.h>
#import <mach-o/dyld.h>

int (*old_clover_point_stock)(void);

int new_clover_point_stock(void)
{
    return 9999;
}

int (*old_ticket_stock)(void);

int new_ticket_stock(void)
{
    return 9999;
}

void (*old_lotterycheck)(uint64_t obj);

void new_lotterycheck(uint64_t obj)
{
    *(int*)(obj + 80) = rand() % 4 + 1;
}

uint64_t (*old_new_clover_object)(uint64_t obj, int index, uint64_t cloverData, uint64_t cloversObj, int fourLeafFlag);

uint64_t new_new_clover_object(uint64_t obj, int index, uint64_t cloverData, uint64_t cloversObj, int fourLeafFlag)
{
    return old_new_clover_object(obj,index,cloverData,cloversObj,1);
}

static __attribute__((constructor)) void _logosLocalCtor_ca63cac5(int __unused argc, char __unused **argv, char __unused **envp){
    @autoreleasepool{
        unsigned long clover_point_stock = _dyld_get_image_vmaddr_slide(0) + 0x100093A2C;
        MSHookFunction((void *)clover_point_stock, (void *)&new_clover_point_stock, (void **)&old_clover_point_stock);

        unsigned long ticket_stock = _dyld_get_image_vmaddr_slide(0) + 0x100093AA4;
        MSHookFunction((void *)ticket_stock, (void *)&new_ticket_stock, (void **)&old_ticket_stock);

        unsigned long lotterycheck = _dyld_get_image_vmaddr_slide(0) + 0x100086CF4;
        MSHookFunction((void *)lotterycheck, (void *)&new_lotterycheck, (void **)&old_lotterycheck);

        unsigned long new_clover_object = _dyld_get_image_vmaddr_slide(0) + 0x100037100;
        MSHookFunction((void *)new_clover_object, (void *)&new_new_clover_object, (void **)&old_new_clover_object);
    }
}
