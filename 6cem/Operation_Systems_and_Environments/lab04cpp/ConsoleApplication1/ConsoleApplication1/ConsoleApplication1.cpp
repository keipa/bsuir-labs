#include <iostream>
#include <thread>
#include "stdafx.h"

using namespace std;
void hello()
{
	printf("Hello Concurrent World\n");
}

int main(int argc, char* argv[])
{
	thread t(hello);
	t.join();
	return 0;
}