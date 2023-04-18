package engine;

import compute.Compute;
import compute.Task;

import java.rmi.RemoteException;
import java.rmi.registry.LocateRegistry;
import java.rmi.registry.Registry;
import java.rmi.server.UnicastRemoteObject;

public class ComputeEngine implements Compute {
    public ComputeEngine() {
        super();
    }

    @Override
    public <T> T executeTask(Task<T> t) throws RemoteException {
        return (T) t.execute();
    }
    public static void main(String[] args) {

//        SecurityManager sm = System.getSecurityManager();
//        if (sm != null) {
//            sm.checkPermission(new SocketPermission("localhost:8080", "connect"));
//        }

        try {
            String name = "Compute";
            Compute engine = new ComputeEngine();
            Compute stub = (Compute) UnicastRemoteObject.exportObject(engine, 0);
            Registry registry = LocateRegistry.getRegistry();
            registry.rebind(name, stub);
            System.out.println("ComputeEngine bound");
        } catch (Exception e) {
            System.err.println("ComputeEngine exception:");
            e.printStackTrace();
        }
    }



}
