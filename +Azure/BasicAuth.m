classdef BasicAuth < handle
    %AUTHORIZATION Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        options
        token
    end
    
    methods
        function obj = BasicAuth(token)
            obj.token = token;
            obj.authorize();
        end
        
        function authorize(obj)
            obj.options = weboptions(...
                'HeaderFields', {'Authorization', ...
                ['Basic ' matlab.net.base64encode(['' ':' obj.token])]...
                }...
            );
        end
    end
    
end

