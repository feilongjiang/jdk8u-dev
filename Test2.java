public class Test2 {
    private String name;

    public Test2(String name) {
        this.name = name;
    }

    @Override
    protected void finalize() throws Throwable {
        try {
            System.out.println("Finalizing " + name);
        } finally {
            super.finalize();
        }
    }
}

public static void main(String[] args) {
    new Thread(() -> {
        Test2 obj = new Test2("Example Object");
        for (int i = 0; i < 200000; i++) {
            obj = new Test2("Example Object" + i);
        }
        obj = null;
    }).start();

    Test2 obj = new Test2("Example Object");
    for (int i = 0; i < 200000; i++) {
        obj = new Test2("Example Object" + i);
    }
    obj = null;
    System.gc();
}