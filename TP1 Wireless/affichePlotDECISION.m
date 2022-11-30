% Visualiser la constellation M-QAM et le codage de Gray
%--------------------------------------------------------
% mComplex : matrice contenant les symboles complexes
% mGray : matrice contenant les codes de Gray

xc = real(an_hat(:));
yc = imag(an_hat(:));

xr = real(an(:));
yr = imag(an(:));

z = mGray(:);

x = real(mComplex(:));
y = imag(mComplex(:));


% new figure
figure

% dessiner les points de la constellation
figure()
scatter(xc,yc,'b*');
figure()
scatter(xr,yr,'g*');


axis([-sqrt(M) sqrt(M) -sqrt(M) sqrt(M)]);

% ajouter codes de Gray 
%for k = 1 : M
 %   text(x(k)-0.6,y(k)+0.3,...
  %      dec2base(z(k),2,log2(M)),'Color',[1 0 0]);
  
%end

% parametres figure
title('Codage de Gray de la M-QAM');
xlabel('I');
ylabel('Q');
grid on

legend('an^','an')