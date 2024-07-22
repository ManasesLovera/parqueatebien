using backend.Models;
using FluentValidation;

namespace backend.Validations;
// Object validator for CitizenVehicleDto
public class CitizenVehicleValidator : AbstractValidator<CitizenVehicle>
{
    public CitizenVehicleValidator()
    {
        RuleFor(x => x.GovernmentId)
            .NotEmpty().NotNull().WithMessage("Falta la cedula del ciudadano")
            .Matches(@"^[0-9]{11}$").WithMessage("El formato de la cedula es inválido. Debe tener 11 numeros.");

        RuleFor(x => x.LicensePlate)
            .NotEmpty().NotNull().WithMessage("Falta la placa del vehiculo")
            .Matches(@"^[A-Z]{1,2}[0-9]{6}$").WithMessage("El formato de la placa es inválido. Debe tener 1 a dos letras mayusculas y 6 numeros.");

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