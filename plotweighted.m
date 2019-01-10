%% »®÷ÿæÿ’Û

function plotweighted(w)
x = 1:length(w);
h = plot(x,w);
set(h,'LineWidth',2.0);
s = gca;
set(s, 'Fontname', 'Times new roman','FontSize',16); 
set(gca,'linewidth',1.5); 
xlabel('The index');
ylabel('The value of weight');
