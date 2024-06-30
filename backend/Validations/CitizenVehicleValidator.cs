using backend.Models;
using FluentValidation;

namespace backend.Validations;

public class CitizenVehicleValidator : AbstractValidator<CitizenVehicle>
{
    public CitizenVehicleValidator()
    {
        RuleFor(x => x.LicensePlate)
            .NotEmpty().NotNull().WithMessage("Falta la placa del vehiculo");

        RuleFor(x => x.RegistrationDocument)
            .NotEmpty().NotNull().WithMessage("Falta matricula del vehiculo");

        RuleFor(x => x.Model)
            .NotEmpty().NotNull().WithMessage("Falta modelo del vehiculo");

        RuleFor(x => x.Year)
            .NotEmpty().NotNull().WithMessage("Falta año del vehiculo");

        RuleFor(x => x.Color)
            .NotEmpty().NotNull().WithMessage("Falta color del vehiculo");
    }
}