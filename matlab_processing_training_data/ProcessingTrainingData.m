clear;clc

%load open price for different currency
load training;
M = [USDBRLtrain,USDCADtrain,USDDKKtrain,USDHUFtrain,USDJPYtrain,USDPLNtrain,USDSEKtrain,USDTRYtrain, USDHKDtrain, USDHKDtrain_close];
M_mean = mean(M)
M_var = var(M)
%standardize
for i=1:length(M(1,:))
    M_Standard(:,i) = (M(:,i)-M_mean(i))/sqrt(M_var(i));
end

M_diff = diff(M_Standard);
%M_diff 2 bits quantization
for j = 1: length(M(1,:))
    y = M_diff(:,j);
    A = max(abs(M_diff(:,j)))*0.7;
    %quantisation
    n = 2; % n bits represent the number of 2^n combinations
    steps = 2^n;% quantization level
    delta_v = 2*A/steps; % quantization interval
    m_i = zeros(1,steps);% mi = a + i*delta_v, quantization_endpoint_value
    for i = 1:steps 
        m_i(i) = -A + i*delta_v;
    end
    m_i_ahead = [-A m_i(1:end-1)]; % mi-1
    % quantization_value qi = (mi+mi-1)/2
    q_i = (m_i + m_i_ahead)/2;

    % find the sampled valued which is the nearst to quantization value
    y_hat = repmat(y,1,steps);
    q_i_hat = repmat(q_i,size(y,1),1);
    [nearst_value,location] = min(abs(y_hat - q_i_hat).');
    %quantized signal
    M_openprice(:,j) = q_i(location);
end
for i = 1: length(M_openprice(:,1))
     if M_openprice(i,10)<0.5*(max(M_openprice(:,10))+min(M_openprice(:,10)))                      %USD-HKD close price trend
         trends(i) = 1;
     else
         trends(i) = -1;
    end
end

        
%seperate labels and predictors
M_input = [M_openprice(:,1:9),trends.'];
