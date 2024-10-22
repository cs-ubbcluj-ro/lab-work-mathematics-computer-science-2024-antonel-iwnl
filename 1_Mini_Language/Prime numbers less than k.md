
antonelgram @start;
int @k;
int @j;
int @i;
bool @is_prime;

Lights out
	re(@k); // reads the value of k
	for @i := 2 to @i - 1 do
		@is_prime := true; // assume @i is prime
		for @j := 2 to @i - 1 do 
			iftry @i mod @j = 0 then 
			@isPrime := false; // @i is not prime 
			elsetry // Do nothing 
			; 
		end
		iftry @is_prime then
			wr(@i); // Print the prime number
		elsetry
			// Do nothing
		;
	end
Checkered flag