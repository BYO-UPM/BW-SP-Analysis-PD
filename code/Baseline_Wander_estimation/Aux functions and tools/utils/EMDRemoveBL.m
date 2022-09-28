function [SIG_Clean] = EMDRemoveBL(sig, Fs, Fc, x)
%  BLW removal method based on Empirical Mode Decomposition
%
%  sig:        the contamined signal
%  Fc:          cut-off frequency
%  Fs:          sample frequiency
%  x:           the number of last IMFs to estimate BW
%  SIG_Clean :  processed signal without BLW
%
%  Reference:
%  Blanco-Velasco M, Weng B, Barner KE. ECG signal denoising and baseline wander
%  correction based on the empirical mode decomposition. Comput Biol Med. 2008;38(1):1–13.
%
%  implemented by: Francisco Perdigon Romero
%  email: fperdigon88@gmail.com


EMD_sig = emd(sig);
EMD_sig = EMD_sig';

[N_imf, L] = size(EMD_sig);

if x >= N_imf
    x = N_imf -1;
end
    
for i = N_imf: -1: N_imf-x
    EMD_sig(i,:) = highPassFilter(EMD_sig(i,:), Fc, Fs);
end

Final_sig = zeros(L,1);
for i = 1 : N_imf
    Final_sig = Final_sig + EMD_sig(i,:)';
end

SIG_Clean = Final_sig;
end

function sig_filt = highPassFilter(sig, F, Fs)
%  High pass IIR filter
%
%  sig:         signal
%  F:           Cut-off Frequency for the filter
%  Fs:          Sampling Frequency
%
%  sig_filt:     Signal contaminated with artificial
%               electric line noise
%
%  Reference:
%
%  implemented by: Francisco Perdigon Romero
%  email: fperdigon88@gmail.com

[b,a] = butter(4,F/Fs,'high');
sig_filt = filtfilt (b,a,sig); % bidirectional filteroing
end
