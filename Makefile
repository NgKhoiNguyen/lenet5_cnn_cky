cpu:		cpu.o custom
		nvcc -o cpu -lm -lcuda -lrt cpu.o network_init.o src/network.o src/mnist.o src/layer/*.o src/loss/*.o src/layer/custom/*.o -I ../libgputk/ -I./

cpu.o:		cpu.cc
		nvcc --compile cpu.cc -I ../libgputk/ -I./

network_init.o:    network_init.cc
		nvcc --compile network_init.cc -I ../libgputk/ -I./

network.o:	src/network.cc
		nvcc --compile src/network.cc -o src/network.o -I ../libgputk/ -I./

mnist.o:	src/mnist.cc
		nvcc --compile src/mnist.cc -o src/mnist.o -I ../libgputk/ -I./

layer:		src/layer/conv.cc src/layer/ave_pooling.cc src/layer/conv_cpu.cc src/layer/conv_cust.cc src/layer/fully_connected.cc src/layer/max_pooling.cc src/layer/relu.cc src/layer/sigmoid.cc src/layer/softmax.cc 
		nvcc --compile src/layer/ave_pooling.cc -o src/layer/ave_pooling.o -I ../libgputk/ -I./
		nvcc --compile src/layer/conv.cc -o src/layer/conv.o -I ../libgputk/ -I./
		nvcc --compile src/layer/conv_cpu.cc -o src/layer/conv_cpu.o -I ../libgputk/ -I./
		nvcc --compile src/layer/conv_cust.cc -o src/layer/conv_cust.o -I ../libgputk/ -I./
		nvcc --compile src/layer/fully_connected.cc -o src/layer/fully_connected.o -I ../libgputk/ -I./
		nvcc --compile src/layer/max_pooling.cc -o src/layer/max_pooling.o -I ../libgputk/ -I./
		nvcc --compile src/layer/relu.cc -o src/layer/relu.o -I ../libgputk/ -I./
		nvcc --compile src/layer/sigmoid.cc -o src/layer/sigmoid.o -I ../libgputk/ -I./
		nvcc --compile src/layer/softmax.cc -o src/layer/softmax.o -I ../libgputk/ -I./

custom:
		nvcc --compile src/layer/custom/cpu-new-forward.cc -o src/layer/custom/cpu-new-forward.o -I ../libgputk/ -I./
		nvcc --compile src/layer/custom/gpu-utils.cu -o src/layer/custom/gpu-utils.o -I ../libgputk/ -I./
		nvcc --compile src/layer/custom/gpu-new-forward-basic.cu -o src/layer/custom/gpu-new-forward-basic.o -I ../libgputk/ -I./
		
loss:           src/loss/cross_entropy_loss.cc src/loss/mse_loss.cc
		nvcc --compile src/loss/cross_entropy_loss.cc -o src/loss/cross_entropy_loss.o -I ../libgputk/ -I./
		nvcc --compile src/loss/mse_loss.cc -o src/loss/mse_loss.o -I ../libgputk/ -I./


clean:
		rm cpu
		rm cpu.o

run: 		cpu
		./cpu 1000