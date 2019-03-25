docker run -it --rm -p 5000:5000 --name zip2000_simple_container --network simple_network -v $PWD/server.js:/myapp/server.js zip2000_simple_container
