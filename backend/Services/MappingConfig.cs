﻿using AutoMapper;
using backend.DTOs;
using backend.Models;

namespace backend.Services;
// Using AutoMapper library for mapping different objects, like from models to DTOs, etc...
public class MappingConfig : Profile
{
    public MappingConfig()
    {
        CreateMap<Report, ReportResponseDto>().ReverseMap();
        CreateMap<ReportDto, Report>().ReverseMap();
        CreateMap<Picture, PictureDto>().ReverseMap();
        CreateMap<UserDto, User>().ReverseMap();
        CreateMap<UserDto, User>().ReverseMap();
        CreateMap<User, UserResponseDto>().ReverseMap();
        CreateMap<CitizenDto, Citizen>().ReverseMap();
        CreateMap<Citizen, CitizenDto>().ReverseMap();

        // Code fixed for issue "Incorrect number of argument supplied for call to method"
        // Stackoverflow: https://stackoverflow.com/questions/77861262/incorrect-number-of-arguments-supplied-for-call-to-method
        AllowNullCollections = true;
        AddGlobalIgnore("Item");
    }
}
