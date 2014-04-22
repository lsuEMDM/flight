// create our OSC receiver
OscRecv recv;
// use port 7476
7476 => recv.port;
// start listening (launch thread)
recv.listen();
// create an address in the receiver, store in new variable
recv.event( "/collide1, f" ) @=> OscEvent collide1;

10 => int N;
0 => int si;


// make osc bank
SinOsc s[N];


JCRev r => dac;
.2 => r.mix;

for (0 => int i; i<N ; i++) {
    0.0 => s[i].gain;   
    s[i] => r; 
}

/*
// infinite event loop
function void loop()
{ */
    while ( true )
    {
        // wait for event to arrive
        collide1 => now;
        
        // grab the next message from the queue. 
        while ( collide1.nextMsg() != 0 ) {
            
            collide1.getFloat() => float frenum;
            
            for ( 0 => int i; i < 20; i++ ) {
                spork ~ toney(frenum,i);
                (10 + i*10)::ms => now;
            }
            
        }
    }
// }
fun void toney(float colfreq, int ind) {
    
        si => int tempsi;
        (si + 1) % N => si;
        
        // getFloat fetches the expected float (as indicated by "f")
        colfreq * Math.random2(1+ind/2,3+ind/2) => float newf;
        newf => s[tempsi].freq;
        <<< newf >>>;
        0.2 => s[tempsi].gain;
        
        // advance time
        100::ms => now;
        0.0 => s[tempsi].gain;
    
}

//spork ~ loop();
//1::week => now;



