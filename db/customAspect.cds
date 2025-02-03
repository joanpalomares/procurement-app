namespace procurement.customAspect;

type Gender      : String(1) @assert.range enum {
    male    = 'M';
    female  = 'F';
    other   = 'O';
    unknown = 'U';
};


// assert.format for checking phone number and email patterns
type phoneNumber : String(30)
@assert.format: '^\s*(?:\+?(\d{1,3}))?[-. (]*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?\s*$';


type email       : String(255)
@assert.format: '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
