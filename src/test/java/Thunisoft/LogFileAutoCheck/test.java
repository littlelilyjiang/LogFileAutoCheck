package Thunisoft.LogFileAutoCheck;

import java.util.ArrayList;
import java.util.List;

public class test {

	public static void main(String[] args) {
		
		//实现方法导致
		List<String> list = new ArrayList<String>();
		list.add("张三");
		list.add("李四");
		list.add("王五");
		for(String string : list){
			System.out.println(string);
			list.remove(string);
		}
	}

}
