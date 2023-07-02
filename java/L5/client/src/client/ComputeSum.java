package client;

import java.rmi.registry.LocateRegistry;
import java.rmi.registry.Registry;
import java.math.BigDecimal;
import java.util.Arrays;
import compute.Compute;

public class ComputeSum {
    public static void main(String args[]) {
        if (System.getSecurityManager() == null) {
            System.setSecurityManager(new SecurityManager());
        }

        try {
            String name = "Compute";
            Registry registry = LocateRegistry.getRegistry(args[args.length-1]);
            Compute comp = (Compute) registry.lookup(name);
            Counter task = new Counter(Arrays.copyOfRange(args, 0, args.length));
            System.out.println(task.execute());
        } catch (Exception e) {
            System.err.println("ComputeSum exception:");
            e.printStackTrace();
        }
    }
}
