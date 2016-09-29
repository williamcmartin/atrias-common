%% Save time, inputs and outputs for the current target model
time_recorded = tg.TimeLog;
data = tg.OutputLog;
data(isnan(tg.OutputLog)) = 0;
data_names = {'q', ...
              'dq', ...
              'incremental', ...
              'accelerometers', ...
              'sagittal_velocity_commands', ...
              'lateral_torque_commands', ...
              'motors_enabled', ...
              'elmo_measured_torques', ...
              'elmo_demanded_torques', ...
              'elmo_measured_velocities', ...
              'elmo_demanded_velocities', ...
              'elmo_error_codes', ...
              'desired_sea_torques'};
data_sizes = [13,...
              13,...
              4,...
              3,...
              4,...
              2,...
              1,...
              4,...
              4,...
              4,...
              4,...
              4,...
              4];
starts = cumsum(data_sizes) - data_sizes + 1;
ends = cumsum(data_sizes);
data_struct = [];
for i=1:length(data_sizes)
    data_struct.([data_names{i},'_recorded']) = data(:,starts(i):ends(i));
end
data_struct.tet_recorded = tg.TETlog;
controller = tg.Application;
file_name = sprintf('data/%s - %s',datestr(clock,'mm_dd_yyyy HH_MM_SS_AM'), controller);
save(file_name, '-struct','data_struct');