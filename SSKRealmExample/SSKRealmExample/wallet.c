//
//  wallet.c
//  SSKRealmExample
//
//  Created by mac on 2019/10/18.
//  Copyright © 2019 SSK. All rights reserved.
//

#include "wallet.h"



void test() {
    
    // 运算符测试
    
    int i = 8;
    int j = 16;
    
    printf("原始值： %i \n", i);
    

    
    // 按位取反
    
    printf("%i \n", ~i);
    
    // 左移三位
    printf("i左移三位 %i \n", i <<= 3);
    
    printf("i -> value: %i \n", i);
    printf("j -> value: %i \n", j);
    printf("按位异或 %i \n", i ^ j);
    
    printf("按位与 %i \n", 11 & 5);
    printf("按位与 %i \n", 15 & 16);
    
    
    printf("按位异或 %i \n", 5 ^ 0);
    
    // https://www.cnblogs.com/L-King/p/5325628.html
    
    
    /* ^ 运算规则：
     
     一个数异或它本身等于0
     与0异或保持不变
     与1异或会翻转
     独位运算，每一位的结果只与该位有关
     
     */
    
    
    // 字节的每一位做&，^等逻辑运算
    
    // 15 & 16
    /*
     
        0000 1111 (2)
      &
        0001 0000 (2)
     ------------------
    r = 0000 0000
     
     
     //
     r(10) = 0
     
     
        0000 1111 (2)
      ^
        0001 0000 (2)
     ------------------
    r = 0001 1111
     
     
     r(10) = 31
     
     
     */
     
    
    
    
    
}
