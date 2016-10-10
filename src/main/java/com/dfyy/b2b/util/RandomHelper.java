package com.dfyy.b2b.util;

import java.util.Random;
import java.util.concurrent.ThreadLocalRandom;

public class RandomHelper {
	public static long getRandomNumber(long scale) {
		return ThreadLocalRandom.current().nextLong(scale) + 1;
	}
	
	
	public  static void main(String[] args){
		System.out.println(getRandomNumber(1));
		System.out.println(getRandomNumber(1));
		System.out.println(getRandomNumber(1));
		System.out.println(getRandomNumber(1));
	}

}