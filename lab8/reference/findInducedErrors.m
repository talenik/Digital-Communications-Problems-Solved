function InducedErrors = findInducedErrors( RealChannelErrors, ErrorsAfterDecoding )
% The uncorrectable error words result in inducing further errors in the
% decoding process. This function finds the number of errors
% induced by the receiver ECC decoder.

% xor doesnt really do what we want 
%IE = xor( RealChannelErrors, ErrorsAfterDecoding )
%InducedErrors = nnz( IE )

IE = RealChannelErrors - ErrorsAfterDecoding ;
InducedErrors = nnz( IE < 0 )

whos RealChannelErrors ErrorsAfterDecoding



