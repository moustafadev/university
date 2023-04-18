package client;

import compute.Compute;

import java.rmi.registry.LocateRegistry;
import java.rmi.registry.Registry;

public class ComputeZerosAndOnes {
    public static void main(String args[]) {
//        if (System.getSecurityManager() == null) {
//            System.setSecurityManager(new SecurityManager());
//        }
        try {
            String name = "Compute";
            Registry registry = LocateRegistry.getRegistry(args[0]);

            Compute comp = (Compute) registry.lookup(name);

            ZerosAndOnes task = new ZerosAndOnes(args);
            String zerosAndOnes = comp.executeTask(task);
            System.out.print(zerosAndOnes);
        } catch (Exception e) {
            System.err.println("ComputeZerosAndOnes exception:");
            e.printStackTrace();
        }
    }
}
