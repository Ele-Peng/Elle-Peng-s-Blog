/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.linglian.github;

import java.io.File;
import java.util.LinkedList;
import javafx.util.Pair;

/**
 *
 * @author lol
 */
public class BlogDoc {

    public static LinkedList getAllMd(String path) {
        return (LinkedList)getAllMd2(path).getKey();
    }

    private static Pair getAllMd2(String path) {
        LinkedList list = new LinkedList();
        File file = new File(path);
        File[] filelist = file.listFiles();
        boolean flag = false;
        for (File f : filelist) {
            if (f.isDirectory()) {
                Pair p = getAllMd2(f.getPath());
                LinkedList tempList = (LinkedList) p.getKey();
                tempList.addFirst(f.getName());
                if (p.getValue().equals(true)) {
                    list.add(tempList);
                    flag = true;
                }
            } else {
                if (f.getName().lastIndexOf(".md") == f.getName().length() - 3) {
                    list.add(f.getName());
                    flag = true;
                }
            }
        }
        return new Pair(list, flag);
    }

    public static LinkedList getAllFile(String path) {
        LinkedList list = new LinkedList();
        File file = new File(path);
        File[] filelist = file.listFiles();
        for (File f : filelist) {
            if (f.isDirectory()) {
                LinkedList tempList = getAllFile(f.getPath());
                tempList.addFirst(f.getName());
                list.add(tempList);
            } else {
                list.add(f.getName());
            }
        }
        return list;
    }

}
